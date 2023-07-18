<section class="content">
    <div class="row">
        <div class="col-sm-6 col-xs-12">
        <div class="card shadow-sm border-bottom-primary">
            <div class="card-header bg-white py-3">
                <div class="row">
                    <div class="col">
                        <h4 class="h5 align-middle m-0 font-weight-bold text-primary">
                            Form Input Permintaan Barang
                        </h4>
                    </div>
                    <div class="col-auto">
                        <a href="<?= base_url('permintaan') ?>" class="btn btn-sm btn-secondary btn-icon-split">
                            <span class="icon">
                                <i class="fa fa-arrow-left"></i>
                            </span>
                            <span class="text">
                                Kembali
                            </span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <?= $this->session->flashdata('pesan'); ?>
                <?= form_open('', [], ['id_req' => $id_req, 'user_id' => $this->session->userdata('login_session')['user']]); ?>
                <div class="row form-group">
                    <label class="col-md-4 text-md-right" for="id_req">ID Transaksi Permintaan Barang</label>
                    <div class="col-md-5">
                        <input value="<?= $id_req; ?>" type="text" readonly="readonly" class="form-control">
                        <?= form_error('id_req', '<small class="text-danger">', '</small>'); ?>
                    </div>
                </div>

                
                
                <div class="row form-group">
                    <label class="col-md-4 text-md-right" for="tgl_req">Tgl Permintaan</label>
                    <div class="col-md-5">
                        <input value="<?= set_value('tgl_req', date('Y-m-d')); ?>" name="tgl_req" id="tgl_req" type="text" class="form-control date" placeholder="Tanggal Permintaan...">
                        <?= form_error('tgl_req', '<small class="text-danger">', '</small>'); ?>
                    </div>
                </div>
               
                <div class="row form-group">
                    <label class="col-md-4 text-md-right" for="barang_id">Barang</label>
                    <div class="col-md-8">
                        <div class="input-group">
                            <select name="barang_id" id="barang_id" class="custom-select">
                                <option value="" selected disabled>Pilih Barang</option>
                                <?php foreach ($barang as $b) : ?>
                                    <option <?= $this->uri->segment(3) == $b['id_barang'] ? 'selected' : '';  ?> <?= set_select('barang_id', $b['id_barang']) ?> value="<?= $b['id_barang'] ?>"><?= $b['id_barang'] . ' | ' . $b['nama_barang'] ?></option>
                                <?php endforeach; ?>
                            </select>
                            <div class="input-group-append">
                                <a class="btn btn-primary" href="<?= base_url('permintaan/add'); ?>"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <?= form_error('barang_id', '<small class="text-danger">', '</small>'); ?>
                    </div>
                </div>
                
                <div class="row form-group">
                    <label class="col-md-4 text-md-right" for="jumlah">Jumlah Permintaan</label>
                    <div class="col-md-5">
                        <div class="input-group">
                            <input value="<?= set_value('jumlah'); ?>" name="jumlah" id="jumlah" type="number" class="form-control" placeholder="Jumlah...">
                            <div class="input-group-append">
                                <span class="input-group-text" id="satuan">Satuan</span>
                            </div>
                        </div>
                        <?= form_error('jumlah', '<small class="text-danger">', '</small>'); ?>
                    </div>
                </div>               

                <div class="row form-group">
                    <div class="col offset-md-4">
                        <button type="submit" class="btn btn-primary">Simpan</button>
                        <button type="reset" class="btn btn-secondary">Reset</button>
                    </div>
                </div>
                <?= form_close(); ?>
            </div>
        </div>
    </div> 
</div>       


              
        